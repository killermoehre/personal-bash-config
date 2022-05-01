#!/bash
declare _path=''
for _path in "$HOME/.local/bin" /usr/local/bin /usr/local/sbin /opt/homebrew/bin /opt/homebrew/sbin; do
    test -d "$_path" && PATH="$_path:$PATH"
done
export PATH
