# =============================================================================
# Claude Code Environment for EMC Midterm Preparation
# =============================================================================

FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# ---- System packages ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg \
    lsb-release \
    make \
    jq \
    python3 \
    python3-pip \
    python3-venv \
    wget \
    && rm -rf /var/lib/apt/lists/*

# ---- Pandoc + LaTeX (for .md → .pdf with rendered equations) ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    pandoc \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-fonts-recommended \
    lmodern \
    && rm -rf /var/lib/apt/lists/*


# ---- Node.js 20 LTS ----
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# ---- Claude Code ----
RUN npm install -g @anthropic-ai/claude-code@latest \
    && claude --version

# ---- Non-root user ----
RUN useradd -m -s /bin/bash claude \
    && mkdir -p /workspace \
    && chown claude:claude /workspace

WORKDIR /workspace
USER claude

CMD ["/bin/bash"]
