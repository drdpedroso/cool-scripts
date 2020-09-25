from domain.model.product.product_repository import ProductRepository

eans = ['']
names = ['']

products = ProductRepository().list_by_eans(eans)
product_by_ean= {p.ean: p for p in products}

for i, ean in enumerate(eans):
    name = product_by_ean[ean].name if len(ean) >= 8 and product_by_ean.get(ean) else names[i]
    print(name)
