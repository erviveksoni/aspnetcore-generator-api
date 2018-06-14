# BUILD STAGE
FROM microsoft/dotnet:2.1-sdk
WORKDIR /integration

COPY integration.csproj .
RUN dotnet restore

COPY . .

ENTRYPOINT ["dotnet","test"]