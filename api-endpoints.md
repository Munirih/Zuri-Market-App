# 📦 Zuri Market API

This is a simple RESTful API built with **Node.js** and **Express** to support an e-commerce application. It provides endpoints for retrieving store information, listing products, and validating shopping carts.

---

# 🚀 Base URL

```
/api
```

---

# 📌 Endpoints

---

## 🏬 Get Store Information

**Method:** `GET`  
**Path:** `/api/store`  
**Authentication Required:** ❌ No  

### 📝 Description
Returns basic information about the store, including its name and total number of products.

### ✅ Example Response

```json
{
  "name": "My Store",
  "totalProducts": 10
}
```

---

## 🛍️ Get All Products

**Method:** `GET`  
**Path:** `/api/products`  
**Authentication Required:** ❌ No  

### 📝 Description
Returns a list of all available products. Supports optional filtering by category.

### ✅ Example Requests

```
GET /api/products
GET /api/products?category=tech
```

### ✅ Example Response

```json
[
  {
    "id": 1,
    "name": "Laptop",
    "category": "tech",
    "price": 1200,
    "stock": 5
  }
]
```

---

## 📦 Get Single Product

**Method:** `GET`  
**Path:** `/api/products/:id`  
**Authentication Required:** ❌ No  

### 📝 Description
Returns details of a single product based on its ID.

### ✅ Example Request

```
GET /api/products/1
```

### ✅ Example Response

```json
{
  "id": 1,
  "name": "Laptop",
  "category": "tech",
  "price": 1200,
  "stock": 5
}
```

### ❌ Example Error Response

```json
{
  "error": "Product not found"
}
```

---

## 🛒 Validate Cart

**Method:** `POST`  
**Path:** `/api/cart/validate`  
**Authentication Required:** ✅ Yes (`x-api-key`)  

### 📝 Description
Validates cart items by checking product existence, stock availability, and calculating totals.

### ✅ Required Headers

```
x-api-key: YOUR_SECRET_KEY
Content-Type: application/json
```

### ✅ Example Request

```json
{
  "items": [
    { "id": 1, "quantity": 2 },
    { "id": 2, "quantity": 1 }
  ]
}
```

### ✅ Example Response

```json
{
  "items": [
    {
      "id": 1,
      "valid": true,
      "name": "Laptop",
      "price": 1200,
      "quantity": 2,
      "subtotal": 2400
    }
  ],
  "total": 2400
}
```

### ❌ Example Unauthorized Response

```json
{
  "error": "Unauthorized: invalid or missing API key"
}
```

---

# 🔐 Authentication

Some endpoints require an API key sent via request headers:

```
x-api-key: YOUR_SECRET_KEY
```

---

# ⚙️ Environment Variables

| Variable | Description | Default |
|--------|------------|--------|
| PORT | Server port | 5000 |
| STORE_NAME | Store name | My Store |
| API_SECRET_KEY | API key for protected routes | — |

