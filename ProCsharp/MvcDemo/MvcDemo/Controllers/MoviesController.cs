using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcDemo.Models;
using System.Threading;

namespace MvcDemo.Controllers
{
    //[Authorize]     // Instead of just at the Action level, the attrb can be applied to the controller as a whole.
    public class MoviesController : Controller
    {
        private MovieDBContext db = new MovieDBContext();

        //
        // GET: /Movies/

        public ViewResult Index()
        {
            ViewBag.Movies = db.Movies.Select(r => r.Title).Distinct(); // to get MovieReview on the home page
            return View(db.Movies.ToList());
        }

        public PartialViewResult Search(string q)
        {
            var movies = db.Movies.Where(r => r.Title.Contains(q) || string.IsNullOrEmpty(q)).Take(5);
            return PartialView("_MovieSearchResults", movies);
        }

        // Defining the function for the autocomplete
        public ActionResult QuickSearch(string term)
        {
            var movies = db.Movies.Where(r => r.Title.Contains(term)).Take(5).Select(r => new { label = r.Title });
            return Json(movies, JsonRequestBehavior.AllowGet);
        }


        public PartialViewResult MovieReview()
        {
            Thread.Sleep(2000);
            var review = "This is a test review text";
            ViewBag.Title = "Movie1";
            ViewBag.Review = review;
            return PartialView("_Review");
            
        }

        //
        // GET: /Movies/Details/5

        public ViewResult Details(int id)
        {
            MovieDB moviedb = db.Movies.Find(id);
            return View(moviedb);
        }

        //
        // GET: /Movies/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Movies/Create

        [HttpPost]
        public ActionResult Create(MovieDB moviedb)
        {
            if (ModelState.IsValid)
            {
                db.Movies.Add(moviedb);
                db.SaveChanges();
                return RedirectToAction("Index");  
            }

            return View(moviedb);
        }
        
        //
        // GET: /Movies/Edit/5
 
        public ActionResult Edit(int id)
        {
            MovieDB moviedb = db.Movies.Find(id);
            return View(moviedb);
        }

        //
        // POST: /Movies/Edit/5

        [HttpPost]
        public ActionResult Edit(MovieDB moviedb)
        {
            if (ModelState.IsValid)
            {
                db.Entry(moviedb).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(moviedb);
        }

        //
        // GET: /Movies/Delete/5
 
        public ActionResult Delete(int id)
        {
            MovieDB moviedb = db.Movies.Find(id);
            return View(moviedb);
        }

        //
        // POST: /Movies/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {            
            MovieDB moviedb = db.Movies.Find(id);
            db.Movies.Remove(moviedb);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}