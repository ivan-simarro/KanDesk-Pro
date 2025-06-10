FROM node:20-bullseye

WORKDIR /app

COPY . .

EXPOSE 3000

CMD ["sh", "-c", " \
  if [ ! -f package.json ]; then \
    echo '📦 Bootstrapping Next.js app...'; \
    npx create-next-app@latest temp --yes --ts --tailwind --eslint --app --src-dir --import-alias \"@/*\" && \
    test -d temp && cp -r temp/* . && rm -rf temp; \
  fi && \
  npm run dev"]
