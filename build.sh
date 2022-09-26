#!/bin/bash

[ ! "${EUID}" = "0" ] && {
  echo "Execute esse script como root:"
  echo
  echo "  sudo ${0}"
  echo
  exit 1
}

HERE="$(dirname "$(readlink -f "${0}")")"

working_dir=$(mktemp -d)

mkdir -p "${working_dir}/usr/lib/tiger-os/"
mkdir -p "${working_dir}/usr/share/applications/"
mkdir -p "${working_dir}/DEBIAN/"

cp -v "${HERE}/jitsi-launcher.sh"      "${working_dir}/usr/lib/tiger-os/"
cp -v "${HERE}/jitsi.png"              "${working_dir}/usr/lib/tiger-os/"
cp -v "${HERE}/jitsi-launcher.desktop" "${working_dir}/usr/share/applications/"

chmod +x "${working_dir}/usr/lib/tiger-os/jitsi-launcher.sh"

(
 echo "Package: jitsi"
 echo "Priority: optional"
 echo "Version: $(date +%y.%m.%d%H%M%S)"
 echo "Architecture: all"
 echo "Maintainer: Daigo Asuka"
 echo "Depends: "
 echo "Description: Solução de videoconferência totalmente criptografada e 100% de código aberto"
 echo
) > "${working_dir}/DEBIAN/control"

dpkg -b ${working_dir}
rm -rfv ${working_dir}

mv "${working_dir}.deb" "${HERE}/jitsi.deb"

chmod 777 "${HERE}/jitsi.deb"
chmod -x  "${HERE}/jitsi.deb"
