echo "Criando imagem singularity..."
cd bnoc
sudo singularity build -F bnoc.simg Singularity

echo "Configurando ambiente..."
if [[ -z $COLLECTION_CONTAINER ]]; then
  COLLECTION_CONTAINER=collection/container
fi
RCLONE_FILE=~/.config/rclone/rclone.conf
mkdir -p "$(dirname "${RCLONE_FILE}")"

echo "Configurando rclone..."
echo "${RCLONE_CONF}" | base64 -d >> "${RCLONE_FILE}"

echo "Enviando arquivos..."
files=( "bnoc.simg" )

rclone copyto "bnoc.simg" "cloud:hpc/containers/${COLLECTION_CONTAINER}/bnoc.simg"
