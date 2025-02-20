var builder = DistributedApplication.CreateBuilder(args);

var productApi = builder.AddProject<Projects.ECommerce_ProductService>("apiservice-product");
var orderApi = builder.AddProject<Projects.ECommerce_OrderService>("apiservice-order");

builder.AddProject<Projects.ECommerce_Web>("webfrontend")
       .WithReference(productApi)
       .WithReference(orderApi);

builder.Build().Run();
