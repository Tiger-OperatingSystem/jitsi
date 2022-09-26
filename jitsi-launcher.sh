#!/bin/bash

export GTK_THEME="Adwaita:dark"

jitsi_url="https://meet.jit.si/$(echo ${RANDOM} ${RANDOM} ${RANDOM} | sha1sum | cut -c 1-21)"

function showLink() {
  echo -e "\nJunte-se a nós na reunião no Jitsi, para acessar basta clicar no link a seguir, não é necessário instalar nenhum aplicativo, tudo acontecerá pelo nevegador\n\n${jitsi_url}" | yad --wrap --margins=32 --text-info --center --borders=32 --width=640 --height=480 --text="<big><b>Quase lá para começar sua reunião</b></big>\nAgora é só copiar a mensagem e mandar para as pessoas e esperar, quando elas abrirem\no link irão entrar na reunião através do navegador\n" --button=gtk-close:1 --button="Começar reunião" --fixed --class=jitsi-launcher --name=jitsi-launcher --title="Jetsi Meet - Gerador de links" --window-icon=Jitsi && {
    ice "${jitsi_url}"
    showLink
  }
}

function newLink() {
  yad --center --borders=32 --fixed --class=jitsi-launcher --name=jitsi-launcher --text="<big><b>Gerar link semi-aleatório</b></big>\nEssa ferramenta permite gerar links para reuniões no Jitsi reuniões usando URLs semi-aleatórias,\nisso adiciona uma camada extra de segurança fazendo com que seja virtualmente impossível alguém\nentrar na sua reunião por engano, mas lembre-se que qualquer um com a URL ainda poderá entrar\nna reunião, então lembre-se de tomar as medidas de segurança básicas\n" --button="Gerar link para reunião" --title="Jetsi Meet - Gerador de links" --window-icon=Jitsi && {
    showLink
  }
}

function openLink() {
  link=$(yad --form --center --borders=32 --fixed --class=jitsi-launcher --name=jitsi-launcher --field="":LE --field=" ":LBL --text="<big><b>Bem vindo(a) ao Jitsi Meet - Entrar em uma reunião</b></big>\nCole ou digite o link para a reunião Jitsi que covidaram você\n<small><i>\n*Note que devido a forma como o Jitsi funciona, caso digite o URL errado você entrará em uma reunião vazia</i></small>\n\n<b>Pro tip:</b> você pode abrir o link diretamente no navegador ao invés de usar esse recurso :)${1}\n" --button="Entrar na reunião":0 --title="Jetsi Meet - Launcher" --window-icon=Jitsi)

  [ ! "${?}" == "0" ] && return

  link=$(echo ${link} | sed 's|^https://meet.jit.si||g;s|^/||g;s|..$||g')

  [ "${link}" = "" ] && {
    openLink "\n\nErro: O link passado está vazio"
  } || {
    ice "https://meet.jit.si/${link}"
  }
}

yad --center --borders=32 --fixed --class=jitsi-launcher --name=jitsi-launcher --text="<big><b>Bem vindo(a) ao Jitsi Meet - O que deseja fazer?</b></big>\nCom ele você pode criar ou entrar em reuniões e conversas usando chamadas de vídeo usando\no seu navegador\n" --button="Começar uma nova reunião":43 --button="Entrar em uma reunião":42 --buttons-layout=spread --title="Jetsi Meet - Launcher" --window-icon=Jitsi

option=${?}

[ "${option}" = "43" ] && newLink
[ "${option}" = "42" ] && openLink
