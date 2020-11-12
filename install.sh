sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV}
  g
  n


  +550M
  n

  +4G
  n



  t
  1
  1
  t
  2
  19
  w
EOF
