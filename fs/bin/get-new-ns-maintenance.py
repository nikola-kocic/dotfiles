#!/usr/bin/env python3

import argparse
from datetime import datetime, timedelta, timezone
import http.client
import json
import os.path
import urllib.parse

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))

def get_data_as_json_string(api_key) -> bytes:
    headers = {
        # Request headers
        'Accept-Language': 'en',
        'Ocp-Apim-Subscription-Key': api_key,
    }

    params = urllib.parse.urlencode({
        # Request parameters
        'type': 'MAINTENANCE',
        'isActive': 'false',
    })

    conn = http.client.HTTPSConnection('gateway.apiportal.ns.nl')
    conn.request("GET", "/reisinformatie-api/api/v3/disruptions?%s" % params, None, headers)
    response = conn.getresponse()
    data = response.read()
    if response.code == 400:
        raise Exception("Bad response: " + data.decode("utf-8"))
    conn.close()
    return data


def parse_iso_time(s: str) -> datetime:
    return datetime.strptime(s, "%Y-%m-%dT%H:%M:%S%z")


def short_time_format(d: datetime) -> str:
    return d.strftime("%a %H:%M")


def short_datetime_format(s: str) -> str:
    d = parse_iso_time(s)
    return d.strftime("%a %Y-%m-%d %H:%M")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--api-key', dest='api_key', required=True)
    args = parser.parse_args()

    filepath = os.path.join(SCRIPT_DIR, "get-new-ns-maintenance-response.json")
    ignore_transport_max_delta = timedelta(hours=8)

    data = None
    get_events_from = None
    try:
        mtime = os.path.getmtime(filepath)
        get_events_from = mtime - (3 * 60)  # just to make sure not to miss anything
        # with open(filepath, "r") as f:
        #     data = json.load(f)
    except:
        data = None

    if data is None:
        # print("File not found or too old, requesting data")
        data_bytes = get_data_as_json_string(args.api_key)
        with open(filepath, "wb") as f:
            f.write(data_bytes)
        data = json.loads(data_bytes.decode("utf-8"))

    for e in data:
        if get_events_from is not None:
            release_timestamp = parse_iso_time(e["releaseTime"]).replace(tzinfo=timezone.utc).timestamp()
            if release_timestamp < get_events_from:
                continue
        publication_sections = e["publicationSections"]
        interesting_traces = []
        for publication_section in publication_sections:
            if publication_section["sectionType"] != "NL":
                continue

            section = publication_section["section"]
            stations = section["stations"]
            for station in stations:
                if station["stationCode"] in ["ALMM", "ALM"]:
                    trace = [s["stationCode"] for s in stations]
                    consequence = publication_section["consequence"]
                    interesting_traces.append({
                        "trace": trace,
                        "consequence": consequence["level"]
                    })
                    break

        if not interesting_traces:
            continue

        print("{} - {}".format(
            short_datetime_format(e["start"]),
            short_datetime_format(e["end"])
        ))
        print("  {} : {}".format(e["id"], e["title"]))

        if len(interesting_traces) > 1:
            print()
        for t in interesting_traces:
            print("  {} : {}".format(t["consequence"], t["trace"]))

        alternative_transports = e["alternativeTransportTimespans"]
        if len(alternative_transports) > 1:
            print()
        for a in alternative_transports:
            start = parse_iso_time(a["start"])
            end = parse_iso_time(a["end"])
            duration = end - start
            if duration < ignore_transport_max_delta and (start.hour < 7 or start.hour == 23) and end.hour < 7:
                continue
            print("  {} - {} : {}".format(
                short_time_format(start),
                short_time_format(end),
                a["alternativeTransport"]["shortLabel"]
            ))

        # print(e)
        print("\n")


if __name__ == "__main__":
    main()
