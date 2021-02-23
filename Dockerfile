FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /WebApp1

# Copy csproj and restore as distinct layers
COPY WebApp1/WebApp1.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /WebApp1
COPY --from=build-env /WebApp1/out .
ENTRYPOINT ["dotnet", "webapp1.dll"]
