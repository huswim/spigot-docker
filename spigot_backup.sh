#!/bin/sh

now=$(date +'%Y-%m-%d-%H:%M:%S')

echo "$now 백업 시작"

name="spigot_bak_$now"

source_path=""
backup_path=""

cp -r $source_path $backup_path/$name

tar -zcvf "$backup_path/$name.tar.gz" "$backup_path/$name" > "$backup_path/$name.log"

rm -r "$backup_path/$name"

echo "$now 백업 완료"
