# =============================================================================
# HSDSD Midterm Preparation — Makefile
# =============================================================================

CLAUDE_IMAGE      := claude-code-env
CLAUDE_CONTAINER  := claude-code-emc
WORKSPACE         := $(shell pwd)

# Load .env if exists
ifneq (,$(wildcard .env))
    include .env
    export
endif

YES       ?= 0   # Set YES=1 to skip confirmation: make claude YES=1

# ---- Validation ----
check-api-key:
ifndef ANTHROPIC_API_KEY
	@echo "ERROR: ANTHROPIC_API_KEY not set. Run: cp .env.example .env && nano .env"
	@exit 1
endif

check-security:
	@echo "==> Security pre-flight checks..."
	@test ! -f .env || (grep -q "sk-ant-PASTE" .env && echo "  ✗ .env still has placeholder key — edit it!" && exit 1 || echo "  ✓ .env has a real key")
	@grep -rq "ANTHROPIC_API_KEY" .git/ 2>/dev/null && echo "  ✗ WARNING: API key found in git history!" || echo "  ✓ No API key in git history"
	@echo "  ✓ Security checks passed"

# ============================
# BUILD
# ============================

.PHONY: build
build: build-claude ## Build Claude Code container
	@echo ""
	@echo "==> Build complete. Next: make verify"

.PHONY: build-claude
build-claude: ## Build the Claude Code Docker image
	docker build -t $(CLAUDE_IMAGE) .

.PHONY: update-claude
update-claude: ## Rebuild Claude Code image, forcing latest npm version (busts cache)
	docker build --no-cache -t $(CLAUDE_IMAGE) .

# ============================
# RUN
# ============================

.PHONY: start
start: check-api-key check-security ## Start Claude Code container (interactive shell)
	docker run -it --rm \
		--name $(CLAUDE_CONTAINER) \
		--env ANTHROPIC_API_KEY \
		--env ANTHROPIC_MODEL \
		--env NTFY_TOPIC \
		-v $(WORKSPACE)/WorkingDir:/workspace \
		$(CLAUDE_IMAGE)

.PHONY: claude
claude: check-api-key check-security ## Launch Claude Code with --dangerously-skip-permissions
	@echo "==> SECURITY REMINDER:"
	@echo "    - Set a spending limit at console.anthropic.com → Billing"
	@echo "    - Claude Code has FULL shell access (--dangerously-skip-permissions)"
	@echo "    - Monitor usage at console.anthropic.com → Usage"
	@echo ""
	@if [ "$(YES)" != "1" ]; then \
		read -p "    Continue? [y/N] " confirm && [ "$$confirm" = "y" ] || exit 1; \
	fi
	docker run -it --rm \
		--name $(CLAUDE_CONTAINER) \
		--env ANTHROPIC_API_KEY \
		--env ANTHROPIC_MODEL \
		--env NTFY_TOPIC \
		-v $(WORKSPACE)/WorkingDir:/workspace \
		$(CLAUDE_IMAGE) \
		bash -c "cd /workspace && claude --dangerously-skip-permissions"

.PHONY: claude-attach
claude-attach: ## Open an additional Claude session inside the already-running container (use in a new tab)
	docker exec -it $(CLAUDE_CONTAINER) bash -c "cd /workspace && claude --dangerously-skip-permissions"

.PHONY: cc
cc: check-api-key ## Smart open: starts Claude if not running, attaches if already running
	@if docker ps -q -f name=$(CLAUDE_CONTAINER) | grep -q .; then \
		echo "==> Container running — opening new session..."; \
		docker exec -it $(CLAUDE_CONTAINER) \
			bash -c "cd /workspace && claude --dangerously-skip-permissions"; \
	else \
		echo "==> No container running — starting fresh..."; \
		if [ "$(YES)" != "1" ]; then \
			echo "    Claude Code has FULL shell access (--dangerously-skip-permissions)"; \
			read -p "    Continue? [y/N] " confirm && [ "$$confirm" = "y" ] || exit 1; \
		fi; \
		docker run -it --rm \
			--name $(CLAUDE_CONTAINER) \
			--env ANTHROPIC_API_KEY \
			--env ANTHROPIC_MODEL \
			--env NTFY_TOPIC \
			-v $(WORKSPACE)/WorkingDir:/workspace \
			$(CLAUDE_IMAGE) \
			bash -c "cd /workspace && claude --dangerously-skip-permissions"; \
	fi

# ============================
# SETUP
# ============================

.PHONY: env-setup
env-setup: ## Create .env from template
	@test -f .env && echo ".env exists already" || (cp .env.example .env && echo "Created .env — edit it: nano .env")

.PHONY: verify
verify: check-api-key ## Verify the full setup
	@echo "==> Verifying environment..."
	@docker image inspect $(CLAUDE_IMAGE) >/dev/null 2>&1 && echo "  ✓ Claude Code image" || echo "  ✗ Claude Code image — run: make build-claude"
	@test -f .env && echo "  ✓ .env file" || echo "  ✗ .env — run: make env-setup"
	@test -f WorkingDir/CLAUDE.md && echo "  ✓ CLAUDE.md" || echo "  ✗ WorkingDir/CLAUDE.md missing"
	@test -d WorkingDir/LectureSlides && echo "  ✓ LectureSlides/" || echo "  ✗ WorkingDir/LectureSlides/ missing"
	@echo "==> Checking Claude Code version inside container..."
	@docker run --rm $(CLAUDE_IMAGE) claude --version 2>/dev/null || echo "  ⚠ Could not check version"
	@echo "==> Checking ntfy.sh notification..."
	@if [ -z "$(NTFY_TOPIC)" ]; then \
		echo "  ⚠ NTFY_TOPIC not set — skipping (add NTFY_TOPIC=your-topic to .env)"; \
	elif curl -sf -o /dev/null \
		-H "Title: EMC verify" \
		-H "Tags: white_check_mark" \
		-d "Verify ping from $$(hostname)" \
		"https://ntfy.sh/$(NTFY_TOPIC)"; then \
		echo "  ✓ ntfy.sh → topic '$(NTFY_TOPIC)' reachable"; \
	else \
		echo "  ✗ ntfy.sh delivery failed — check NTFY_TOPIC and network"; \
	fi
	@echo "==> Done."

# ============================
# CLEANUP
# ============================

.PHONY: stop
stop: ## Stop running container
	-docker stop $(CLAUDE_CONTAINER) 2>/dev/null

.PHONY: clean
clean: stop ## Remove container + Claude image
	-docker rm $(CLAUDE_CONTAINER) 2>/dev/null
	-docker rmi $(CLAUDE_IMAGE) 2>/dev/null

# ============================
# HELP
# ============================

.PHONY: help
help: ## Show this help
	@echo "======================================================"
	@echo " EMC Midterm Preparation"
	@echo "======================================================"
	@echo ""
	@echo " QUICK START:"
	@echo "   1. make env-setup        # Create .env config"
	@echo "   2. nano .env             # Add your API key"
	@echo "   3. make build            # Build container"
	@echo "   4. make verify           # Check everything"
	@echo "   5. make claude           # Launch Claude Code"
	@echo ""
	@echo " TIPS:"
	@echo "   make cc                  # Smart open: starts or attaches automatically"
	@echo "   make cc YES=1            # Same, skip confirmation on first start"
	@echo ""
	@echo " COMMANDS:"
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "   \033[36m%-18s\033[0m %s\n", $$1, $$2}'
	@echo ""

.DEFAULT_GOAL := help
