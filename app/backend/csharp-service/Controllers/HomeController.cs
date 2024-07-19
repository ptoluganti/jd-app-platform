using Microsoft.AspNetCore.Mvc;

namespace csharp_service.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HomeController : ControllerBase
    {
        
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        [HttpGet()]
        public IActionResult Get()
        {
            var headers = Request.Headers.ToList();
            return Ok(new { headers });
        }
    }
}
