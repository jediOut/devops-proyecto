echo "=== AUDIT DE SEGURIDAD ==="
echo ""
echo "1. .gitignore incluye .env:"
grep -q ".env" .gitignore && echo "  ✅ OK" || echo "  ❌ FALTA"


echo "2. No hay secrets en el código:"
gitleaks detect --source . --no-git 2>/dev/null && echo "  ✅ OK" || echo "  ❌ REVISAR"

echo "3. Dependabot configurado:"
test -f .github/dependabot.yml && echo "  ✅ OK" || echo "  ❌ FALTA"

echo "4. Trivy en el pipeline:"
grep -q "trivy" .github/workflows/ci.yml && echo "  ✅ OK" || echo "  ❌ FALTA"

echo "5. Dockerfile no usa imagen latest:"
grep -q "FROM python:latest" Dockerfile && echo "  ❌ USAR VERSION FIJA" || echo "  ✅ OK"

echo "6. Dockerfile usa usuario no root:"
grep -q "USER" Dockerfile && echo "  ✅ OK" || echo "  ❌ FALTA USER appuser"

echo ""
echo "=== FIN DEL AUDIT ==="

