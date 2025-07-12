using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace Microsoft.eShopWeb.Infrastructure.Identity
{
    public class AppIdentityDbContextFactory : IDesignTimeDbContextFactory<AppIdentityDbContext>
    {
        public AppIdentityDbContext CreateDbContext(string[] args)
        {
            var connectionString = "Server=localhost;Database=Microsoft.eShopOnWeb.Identity;Trusted_Connection=True;Encrypt=False;";
            var optionsBuilder = new DbContextOptionsBuilder<AppIdentityDbContext>();
            optionsBuilder.UseSqlServer(connectionString);

            return new AppIdentityDbContext(optionsBuilder.Options);
        }
    }
}
