ligolosetup(){
  # Variables
  LIGOLO_VERSION="0.8.1"

  # Crear directorios
  echo -e "[+] Creando los directorios..."
  mkdir -p ./ligolo/proxy ./ligolo/agent/linux ./ligolo/agent/windows

  # Comprobar si wget está instalado
  if ! command -v wget &> /dev/null
  then
    echo "[!] wget no está instalado. Por favor, instálalo antes de continuar."
    return 1
  fi

  # Comprobar si 7z está instalado
  if ! command -v 7z &> /dev/null
  then
    echo "[!] 7z no está instalado. Por favor, instálalo antes de continuar."
    return 1
  fi

  # Descargar archivos
  echo -e "[+] Descargando los archivos..."
  wget "https://github.com/nicocha30/ligolo-ng/releases/download/v${LIGOLO_VERSION}/ligolo-ng_proxy_${LIGOLO_VERSION}_linux_amd64.tar.gz" -O ./ligolo/proxy/ligolo-ng_proxy_${LIGOLO_VERSION}_linux_amd64.tar.gz &>/dev/null
  wget "https://github.com/nicocha30/ligolo-ng/releases/download/v${LIGOLO_VERSION}/ligolo-ng_agent_${LIGOLO_VERSION}_linux_amd64.tar.gz" -O ./ligolo/agent/linux/ligolo-ng_agent_${LIGOLO_VERSION}_linux_amd64.tar.gz &>/dev/null
  wget "https://github.com/nicocha30/ligolo-ng/releases/download/v${LIGOLO_VERSION}/ligolo-ng_agent_${LIGOLO_VERSION}_windows_amd64.zip" -O ./ligolo/agent/windows/ligolo-ng_agent_${LIGOLO_VERSION}_windows_amd64.zip &>/dev/null

  # Extraer binarios y eliminar archivos intermedios
  echo -e "[+] Extrayendo los archivos..."
  cd ./ligolo/proxy &>/dev/null
  7z x ligolo-ng_proxy_${LIGOLO_VERSION}_linux_amd64.tar.gz &>/dev/null && rm ligolo-ng_proxy_${LIGOLO_VERSION}_linux_amd64.tar.gz &>/dev/null
  7z x ligolo-ng_proxy_${LIGOLO_VERSION}_linux_amd64.tar &>/dev/null && rm ligolo-ng_proxy_${LIGOLO_VERSION}_linux_amd64.tar &>/dev/null
  cd ../.. &>/dev/null

  cd ./ligolo/agent/linux &>/dev/null
  7z x ligolo-ng_agent_${LIGOLO_VERSION}_linux_amd64.tar.gz &>/dev/null && rm ligolo-ng_agent_${LIGOLO_VERSION}_linux_amd64.tar.gz &>/dev/null
  7z x ligolo-ng_agent_${LIGOLO_VERSION}_linux_amd64.tar &>/dev/null && rm ligolo-ng_agent_${LIGOLO_VERSION}_linux_amd64.tar &>/dev/null
  cd ../../.. &>/dev/null

  cd ./ligolo/agent/windows &>/dev/null
  7z x ligolo-ng_agent_${LIGOLO_VERSION}_windows_amd64.zip &>/dev/null && rm ligolo-ng_agent_${LIGOLO_VERSION}_windows_amd64.zip &>/dev/null
  cd ../../.. &>/dev/null

  echo -e "[+] Deseas reducir el tamaño de los ejecutables con upx? [y/N]"
  read response
  if [[ "$response" == "y" || "$response" == "Y"  ]]; then
        if ! command -v upx &> /dev/null; then
                echo -e "[!] upx no está instalado. El setup se completó sin la reducción del tamaño"
                return 1;
        else
                upx -9 ./ligolo/proxy/proxy &>/dev/null
                upx -9 ./ligolo/agent/linux/agent &>/dev/null
                upx -9 ./ligolo/agent/windows/agent.exe &>/dev/null
        fi
  fi


  echo "[+] ¡Configuración de ligolo-ng completa!"
}
