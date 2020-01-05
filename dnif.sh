#!/bin/sh

_search_paths() {
  search_path=$1

  while [ -n "${search_path}" ]; do
    # returns current folder as a result
    echo "${search_path}"

    # move to parent folder if exists
    [[ "${search_path}" == */* ]] && search_path=$(echo ${search_path} | sed 's#\(.*\)/.*#\1#')
  done

  # return root location
  echo "/"
}

search_path=$1; shift 1

# make sure initial location exists
test -d "${search_path}" || exit 1

search_paths=$(_search_paths ${search_path} | awk '{ a[i++]=$0 } END { for (j=i-1; j>=0;) print a[j--] }')

for search_path in ${search_paths}; do
  find ${search_path} -maxdepth 1 $@
done