# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY ExamQualificationApp.csproj ./
RUN dotnet restore ExamQualificationApp.csproj

COPY . ./
RUN dotnet publish ExamQualificationApp.csproj \
    --configuration Release \
    --output /app/publish \
    --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS final

WORKDIR /app

COPY --from=build /app/publish ./

ENTRYPOINT ["dotnet", "ExamQualificationApp.dll"]