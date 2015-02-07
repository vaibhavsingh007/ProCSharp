using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcDependencyResolver.Models;

namespace MvcDependencyResolver.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var model = new DependencyData
                            {
                                Edges = "A:C, C:B, C:D"
                            };

            ViewBag.Message = "Welcome to ASP.NET MVC!";

            return View(model);
        }

        public ActionResult About()
        {
            return View();
        }
    }
}
