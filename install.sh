find . \
    -not -path "./.git*" \
    -not -path "." \
    -type d \
    -exec echo Creating directory  ~/\{\} \;\
    -exec mkdir ~/\{\} \;

find . \
    -not -path "./.git*" \
    -not -path "./install.sh" \
    -type f \
    -exec echo Linking \{\} \; \
    -exec ln -s $(readlink -f \{\}) ~/\{\} \;

