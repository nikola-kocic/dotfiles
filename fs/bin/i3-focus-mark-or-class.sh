[ $(i3-msg "[con_mark=\"${1}\"] focus") = '[{"success":true}]' ] || i3-msg "[class=\"^${2}$\"] focus"
