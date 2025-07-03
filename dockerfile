FROM python:3.11.13-alpine3.22 
# o alpine é uma imagem leve baseada em Alpine Linux, ideal para produção para o uso em contêineres  


# Define variáveis de ambiente para otimizar a execução em contêineres
# Impede o Python de criar arquivos .pyc, economizando espaço


# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker
COPY requirements.txt .

# Atualiza o pip e instala as dependências
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação
COPY . .

# Expõe a porta 8000 para permitir a comunicação com a aplicação
EXPOSE 8000

# Comando para iniciar a aplicação em modo de produção
# O host 0.0.0.0 é necessário para que a aplicação seja acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host","0.0.0.0", "--port", "8000", "--reload"]