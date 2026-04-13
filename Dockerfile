# =============================================================================
# Claude Code Environment for HSDSD Midterm Preparation
# =============================================================================

FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# ---- All system packages in one layer ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git make jq xz-utils \
    python3 python3-pip python3-venv \
    pandoc \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-fonts-recommended \
    lmodern \
    poppler-utils \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

# ---- Node.js 22 LTS (direct binary, no NodeSource repo) ----
ARG NODE_VERSION=22.15.0
RUN ARCH=$(dpkg --print-architecture) \
    && if [ "$ARCH" = "amd64" ]; then NODE_ARCH=x64; \
       elif [ "$ARCH" = "arm64" ]; then NODE_ARCH=arm64; \
       else echo "Unsupported arch: $ARCH" && exit 1; fi \
    && curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz" \
       | tar -xJ -C /usr/local --strip-components=1 \
    && node --version && npm --version

# ---- Claude Code + uv ----
RUN npm install -g @anthropic-ai/claude-code@latest \
    && claude --version \
    && pip install --break-system-packages uv \
    && npm cache clean --force

# ---- Non-root user ----
RUN useradd -m -s /bin/bash claude \
    && mkdir -p /workspace \
    && chown claude:claude /workspace

WORKDIR /workspace
USER claude

# ---- Pre-cache AWS Document Loader MCP server ----
RUN uvx awslabs.document-loader-mcp-server@latest --help || true

CMD ["/bin/bash"]
