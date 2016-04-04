#!/bin/bash

createfile()
{
  echo -n "Введите имя файла: "
  read name
  if [ -z "$name" ]
  then
 	mymenu
  else
 	if [ -e ${name} ]
	then
		echo "Файл с таким именем уже существует! Попробуйте ввести другое имя"
		createfile
	else
		c='touch '${name}
		`$c`
		mymenu
	fi
  fi
}

renamefile(){
  echo -n "Введите старое имя файла: "
  read oldname
  if [ -z "$oldname" ]
  then
	mymenu
  else
	if [ -e ${oldname} ]
	then
		#запрос нового имени
		echo -n "Введите новое имя файла: "
  		read newname
  		if [ -z "$newname" ]
  		then
			mymenu
  		else
			while [ -e "$newname" ] 
			do
				echo "Файл с таким именем уже существует!"				
				echo -n "Введите новое имя файла: "
  				read newname
			done
			c='mv '${oldname}' '${newname} 
			`$c`
			mymenu
		fi
	else
		echo "Файла с таким именем не существует!"
		renamefile
	fi
  fi
}

mymenu(){

v1="список файлов и подкаталогов текущего каталога"
v2="создание файла"
v3="переименование файла"
v4="выход из скрипта"

select opt in "$v1" "$v2" "$v3" "$v4"
do
	if [ "$opt" == "$v1" ]
	then
	  c="ls"
	  echo `$c`
	  mymenu
	fi
	if [ "$opt" == "$v2" ]
	then
	  createfile
	fi
	if [ "$opt" == "$v3" ]
	then
	  renamefile
	fi
	if [ "$opt" == "$v4" ]
	then
	  echo "Всего доброго! Хорошего дня!"
	  exit
	fi
done
}

mymenu
