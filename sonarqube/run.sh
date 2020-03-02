#!/bin/bash

set -e

if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

# CodeSmell's plugin, PMD, Checkstyle, Findbugs install

PLUGIN="sonar-codesmellsantipatterns-plugin-0.7.jar"

chown -R sonarqube:sonarqube $SONARQUBE_HOME

if [ ! -f $SONARQUBE_HOME/extensions/plugins/$PLUGIN ]; then
    curl -Lo "$SONARQUBE_HOME/extensions/plugins/$PLUGIN" "https://github.com/davidetaibi/sonarqube-anti-patterns-code-smells/releases/download/0.7/$PLUGIN"
 #  curl -Lo "$SONARQUBE_HOME/extensions/plugins/sonar-pmd-plugin-3.2.1.jar" "https://github.com/jensgerdes/sonar-pmd/releases/download/3.2.1/sonar-pmd-plugin-3.2.1.jar"
 #   curl -Lo "$SONARQUBE_HOME/extensions/plugins/checkstyle-sonar-plugin-4.27.jar" "https://github.com/checkstyle/sonar-checkstyle/releases/download/4.27/checkstyle-sonar-plugin-4.27.jar"
 #   curl -Lo "$SONARQUBE_HOME/extensions/plugins/sonar-findbugs-plugin-3.11.1.jar" "https://github.com/spotbugs/sonar-findbugs/releases/download/3.11.1/sonar-findbugs-plugin-3.11.1.jar"
fi

exec gosu sonarqube \
  java -jar lib/sonar-application-$SONAR_VERSION.jar \
  -Dsonar.log.console=true \
  -Dsonar.jdbc.username="$SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$SONARQUBE_JDBC_URL" \
  -Dsonar.web.context="$SONARQUBE_WEB_CONTEXT"
  -Dsonar.web.javaAdditionalOpts="$SONARQUBE_WEB_JVM_OPTS -Djava.security.egd=file:/dev/./urandom" \
"$@"
