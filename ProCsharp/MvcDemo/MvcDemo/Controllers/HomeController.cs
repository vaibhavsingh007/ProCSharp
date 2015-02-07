using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcDemo.Models;

namespace MvcDemo.Controllers
{
    public class HomeController : Controller
    {
        private MovieDBContext _db = new MovieDBContext();

        public ActionResult JsonSearch(string q)
        {
            var movies = _db.Movies
                            .Where(r => r.Title.Contains(q))
                            .Take(10)
                            .Select(r => new
                            {
                                r.Title,
                                r.Director
                            });
            return Json(movies, JsonRequestBehavior.AllowGet);
        }   //Now add the required script to Movies.js
            
        public ActionResult Index()
        {
            ViewBag.Message = "Welcome to my first ASP.NET MVC Internet Application!";

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "This is Viewbag.Message in the About() HomeController!";
            return View();
        }
    }
}
