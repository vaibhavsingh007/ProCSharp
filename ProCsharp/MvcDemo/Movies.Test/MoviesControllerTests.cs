using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using MvcDemo.Controllers;

namespace Movies.Tests
{
    [TestFixture]
    public class MoviesControllerIndexTests
    {
        [Test]
        public void PutsMessageInViewBag()
        {
            var controller = new MoviesController();    // Controllers are easy to instantiate
            var result = controller.Index();

            // Now assert if the viewbag.movies in that Index() is not null
            Assert.IsNotNull(result.ViewBag.Movies);
        }
    }
}
