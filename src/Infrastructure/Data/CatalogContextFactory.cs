using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace Microsoft.eShopWeb.Infrastructure.Data
{
    public class CatalogContextFactory : IDesignTimeDbContextFactory<CatalogContext>
    {
        public CatalogContext CreateDbContext(string[] args)
        {
            // ✅ الاتصال المباشر مع إيقاف التشفير
            var connectionString = "Server=localhost;Database=Microsoft.eShopOnWeb.CatalogDb;Trusted_Connection=True;Encrypt=False;";
            var optionsBuilder = new DbContextOptionsBuilder<CatalogContext>();
            optionsBuilder.UseSqlServer(connectionString);

            return new CatalogContext(optionsBuilder.Options);
        }
    }
}
