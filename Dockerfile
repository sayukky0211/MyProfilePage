# ビルド用ステージ
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# ファイル全部コピー
COPY . ./

# ✅ プロジェクトファイルを明示的に指定！
RUN dotnet publish MyProfilePage.csproj -c Release -o out

# 実行用ステージ
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

COPY --from=build /app/out .

# 実行！
ENTRYPOINT ["dotnet", "MyProfilePage.dll"]
