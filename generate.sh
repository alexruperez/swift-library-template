if [ -z "$1" ]
then
  origin=$(git remote get-url origin)
  end=${origin##*/}
  unsafe=${end%.*}
  name=$(echo $unsafe | perl -pe 's/(^|-|_)([a-z])/uc($2)/ge' )
else
  name=$1
fi

for path in $(find . -type d -path "*LIBRARY-NAME*")
do
  mv $path ${path//LIBRARY-NAME/$name}
done

for path in $(find . -type f ! -path "./.*" ! -name "*.sh" ! -name ".DS_Store")
do
  sed -i "" -e "s/LIBRARY-NAME/$name/g" $path
  if [[ $path =~ "LIBRARY-NAME" ]]
  then
    mv $path ${path//LIBRARY-NAME/$name}
  fi
done

swift package generate-xcodeproj

rm -rf ./generate.sh
