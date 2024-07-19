package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)


func main() {
	router := gin.Default()
	router.GET("/health", getHealth)
	router.GET("/", getAllHeaders)
	
	router.Run()
}

// getHealth responds with a simple health status.
func getHealth(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{"status": "healthy"})
}

// getAllHeaders returns all the headers from the request.
func getAllHeaders(c *gin.Context) {
	headers := c.Request.Header
	c.IndentedJSON(http.StatusOK, headers)
}