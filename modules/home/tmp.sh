for f in *; do
  # Only check .nix files or directories with default.nix
  if [ -d "$f" ]; then
    file="$f/default.nix"
  else
    file="$f"
  fi
  if [ -f "$file" ]; then
    # Is the first non-comment, non-empty line a function header?
    head -20 "$file" | grep -Eq '^\s*\{.*\}\s*:' || echo "Potential problem: $file"
  fi
done
