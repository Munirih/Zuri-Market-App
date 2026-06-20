
# Backend Endpoints

---

## Get Store Information

**Method:** `GET`  
**Path:** `/api/store`  
**Authentication Required:** No  

### Description
Returns basic information about the store, including its name and total number of products.

### Example Response

```json

{
  "name": "Zuri Market",
  "totalProducts":8 
}

```

---

## Get All Products

**Method:** `GET`  
**Path:** `/api/products`  
**Authentication Required:** No  

### Description
Returns a list of all available products. Supports optional filtering by category.

### Example Requests

```
GET /api/products
GET /api/products?category=tech
```

### Example Response

```json
[
  {
    "id": 4,
    "name": "Wireless earbuds",
    "category": "tech",
    "price": 129,
    "stock": 20,
    "badge": "new",
    "description": "Active noise cancellation, 28-hour battery life, IPX4 water resistance.",
    "image": "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500&q=80"
  },
  {
    "id": 8,
    "name": "Desk organiser set",
    "category": "tech",
    "price": 55,
    "stock": 18,
    "badge": null,
    "description": "Modular cork and steel tray system. Fits monitors up to 32 inches.",
    "image": "https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=500&q=80"
  }
]
```

---

## Get Single Product

**Method:** `GET`  
**Path:** `/api/products/:id`  
**Authentication Required:** No  

### Description
Returns details of a single product based on its ID.

### Example Request

```
GET /api/products/2
```

### Example Response

```json
{
  "id":2,
  "name":"Ceramic pour-over",
  "category":"home",
  "price":42,
  "stock":8,
  "badge":"bestseller",
  "description":"Hand-thrown ceramic dripper. Brews a clean, nuanced cup every time.",
  "image":"https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500&q=80"
}
```

### Example Error Response

```json
{
  "error": "Product not found"
}
```

---

## Validate Cart

**Method:** `POST`  
**Path:** `/api/cart/validate`  
**Authentication Required:** Yes (`x-api-key`)  

### Description
Validates cart items by checking product existence, stock availability, and calculating totals.

### Required Headers

```
x-api-key: YOUR_SECRET_KEY
Content-Type: application/json
```

### Example Unauthorized Response

```json
{
  "error": "Unauthorized: invalid or missing API key"
}
```




