VBR="600k"                                    # Bitrate de la vidéo en sortie
FPS="30"                                       # FPS de la vidéo en sortie
QUAL="medium"                                  # Preset de qualité FFMPEG
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  # URL de base RTMP youtube
#rtmp://b.rtmp.youtube.com/live2?backup=1
SOURCE=":0.0 "                                 # Source UDP (voir les annonces SAP)
KEY="0sy7-ksd1-uy7c-fx3b"                      # Clé à récupérer sur l'event youtube

ffmpeg \
    -f x11grab -video_size 1366x768 -i :0.0 -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
    -f flv "$YOUTUBE_URL/$KEY"
