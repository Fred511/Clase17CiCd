# ---------- etapa 1: CONSTRUCCIÓN ----------
FROM maven:3.9-eclipse-temurin-26 AS build
WORKDIR /build
# 1. Solo el pom primero: cachea las dependencias en su propia capa.
COPY pom.xml .
RUN mvn -q dependency:go-offline
# 2. Ahora el código: si cambias código pero no el pom, NO se re-descargan dependencias.
COPY src ./src
RUN mvn -q clean package -DskipTests

# ---------- etapa 2: EJECUCIÓN ----------
FROM eclipse-temurin:26-jre
WORKDIR /app
# Solo el jar cruza desde la etapa de construcción. Maven y el fuente se quedan atrás.
COPY --from=build /build/target/*.jar app.jar
RUN useradd -r -u 1001 appuser && chown -R appuser /app
USER appuser
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
