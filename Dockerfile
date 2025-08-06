FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# ソリューションと csproj をコピー
COPY *.sln ./
COPY *.csproj ./
COPY NuGet.Config ./  # プライベートフィード用（必要に応じて）
RUN dotnet restore --verbosity detailed

# 残りのファイルをコピーしてビルド
COPY . ./
RUN dotnet publish -c Release -o out

# ランタイムイメージ
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "MyProfilePage.dll"]