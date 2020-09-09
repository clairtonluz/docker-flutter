echo 'Building image flutter 1.20.3 - JDK 11 - SDK 28'
docker build -t clairtonluz/flutter -t clairtonluz/flutter:1.20.3-sdk-28 .

echo 'Building image sonar-scanner-flutter'
docker build -t clairtonluz/flutter:1.20.3-sdk-28-sonar-scanner sonar-scanner/

echo 'Pushing images'
docker push clairtonluz/flutter:latest 
docker push clairtonluz/flutter:1.20.3-sdk-28
docker push clairtonluz/flutter:1.20.3-sdk-28-sonar-scanner