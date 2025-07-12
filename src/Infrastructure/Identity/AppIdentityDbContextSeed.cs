using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.eShopWeb.ApplicationCore.Constants;

namespace Microsoft.eShopWeb.Infrastructure.Identity;

public class AppIdentityDbContextSeed
{
    public static async Task SeedAsync(AppIdentityDbContext identityDbContext, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
    {
        if (identityDbContext.Database.IsSqlServer())
        {
            identityDbContext.Database.Migrate();
        }

        // ✅ تحقق من وجود الدور قبل إضافته
        var adminRoleName = BlazorShared.Authorization.Constants.Roles.ADMINISTRATORS;
        if (!await roleManager.RoleExistsAsync(adminRoleName))
        {
            await roleManager.CreateAsync(new IdentityRole(adminRoleName));
        }

        // ✅ تحقق من وجود demouser قبل إضافته
        var demoEmail = "demouser@microsoft.com";
        var demoUser = await userManager.FindByEmailAsync(demoEmail);
        if (demoUser == null)
        {
            demoUser = new ApplicationUser { UserName = demoEmail, Email = demoEmail };
            await userManager.CreateAsync(demoUser, AuthorizationConstants.DEFAULT_PASSWORD);
        }

        // ✅ تحقق من وجود admin user قبل إضافته
        string adminUserName = "admin@microsoft.com";
        var adminUser = await userManager.FindByNameAsync(adminUserName);
        if (adminUser == null)
        {
            adminUser = new ApplicationUser { UserName = adminUserName, Email = adminUserName };
            await userManager.CreateAsync(adminUser, AuthorizationConstants.DEFAULT_PASSWORD);
        }

        // ✅ تأكد من إضافة admin user إلى الدور إن لم يكن فيه
        if (!await userManager.IsInRoleAsync(adminUser, adminRoleName))
        {
            await userManager.AddToRoleAsync(adminUser, adminRoleName);
        }
    }
}
