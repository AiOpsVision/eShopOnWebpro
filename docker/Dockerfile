# ========================
# Build stage
# ========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /eShopApp
COPY . .
RUN dotnet restore eShopOnWeb.sln
RUN dotnet publish src/Web/Web.csproj -c Release -o /eShopApp/publish

# ========================
# Runtime stage
# ========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /eShopApp
COPY --from=build /eShopApp/publish .
ENTRYPOINT ["dotnet", "Web.dll"]
