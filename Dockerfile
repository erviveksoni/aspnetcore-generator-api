# BUILD STAGE
FROM microsoft/dotnet:2.1-sdk as build-env
WORKDIR /generator

COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

COPY . .

#RUN ls -alR

RUN dotnet test tests/tests.csproj

RUN dotnet publish api/api.csproj -c release -o /publish

## RUNTIME IMAGE STAGE
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet","/publish/api.dll"]