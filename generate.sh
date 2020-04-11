if [ -z "$1" ]
then
  echo "Remember to specify the name of your library."
  exit 1
fi

for path in $(find . -type d -path "*LIBRARY-NAME*")
do
  mv $path ${path//LIBRARY-NAME/$1}
done

for path in $(find . -type f ! -path "./.*" ! -name "*.sh" ! -name ".DS_Store")
do
  sed -i "" -e "s/LIBRARY-NAME/$1/g" $path
  if [[ $path =~ "LIBRARY-NAME" ]]
  then
    mv $path ${path//LIBRARY-NAME/$1}
  fi
done

swift package generate-xcodeproj

rm -rf ./generate.sh
