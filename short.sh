#!/bin/sh

repo=$KEYK_APP__REPO
cd $repo

url="$1"; echo $url
code="$2"; echo $code
test -z "$code" && code="$(openssl rand -hex 5 | head -c 5)"
test -n "$url" && echo "/$code $url" >>_redirects
out="$(column -s ' ' -t -c 2 <_redirects | sort | uniq)"
echo "$out" | grep -v "^/\*" >_redirects
echo >>_redirects
echo "$out" | grep "^/\*" >>_redirects

git add .; git commit --message="unattended"; git push
cd -