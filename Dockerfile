# Use the official Node.js 14 Alpine image as the base
FROM node:18

# Set the working directory inside the container
WORKDIR /app


# Install Truffle globally
RUN npm install -g truffle

# Expose the default Truffle development port
EXPOSE 9545

ENTRYPOINT ["docker-entrypoint.sh"]

# Start the Truffle development console by default
CMD ["bash"]