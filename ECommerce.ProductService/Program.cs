using ECommerce.ProductService.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<ProductDbContext>(option =>
                                                //option.UseSqlServer("Server=SGLT22019;Database=ECommerceProduct;User Id=sa;Password=P@$$w0rd;TrustServerCertificate=True;"));
                                                option.UseSqlServer("Server=DESKTOP-C2EGOC5;Database=ECommerceProduct;User Id=sa;Password=P@$$w0rd;TrustServerCertificate=True;"));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
