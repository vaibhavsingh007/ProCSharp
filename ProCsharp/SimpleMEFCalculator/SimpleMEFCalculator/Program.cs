using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;            //MEF
using System.ComponentModel.Composition.Hosting;    //MEF

namespace SimpleMEFCalculator
{
    class Program
    {
        //Composition container contains all the parts available and performs composition.
        //(That is, the matching up of imports to exports.)
        private CompositionContainer _container;

        private Program()
        {
            //A catalog is an object that makes available parts discovered from some source.
            //An aggregate catalog combines multiple catalogs
            var catalog = new AggregateCatalog();

            //Add all the 'parts' found in the same assemply as the Program class
            catalog.Catalogs.Add(new AssemblyCatalog(typeof(Program).Assembly));

            //Adding catalog to search the 'Extensions' directory too.
            catalog.Catalogs.Add(new DirectoryCatalog("C:\\Users\\test\\Documents\\Visual Studio 2010\\Projects\\ASPdotnet\\ProCsharp\\ProCsharp\\SimpleMEFCalculator\\SimpleMEFCalculator\\Extensions"));

            //Create the CompositionContainer with the 'parts' in the Catalog
            _container = new CompositionContainer(catalog);

            //Fill the imports of 'this'(Program class') object
            try
            {
                /* The call to ComposeParts tells the composition container to compose a specific set of parts, 
                 * in this case the current instance of Program. At this point, however, nothing will happen, 
                 * since Program has no imports to fill.
                 */
                this._container.ComposeParts(this);
            }
            catch (CompositionException compositionException)
            {
                Console.WriteLine(compositionException.ToString());
            }
        }

        /*Import a single object of type ICalculator that must be exported somewhere in this assembly as discovered
        by the catalog above. Every import has a contract, which determines what exports it will be matched with.
        The contract is independent from the type of the importing object. (In this case, you could leave out the 
        typeof(ICalculator). MEF will automatically assume the contract to be based on the type of the import unless 
        you specify it explicitly.)
         */
        [Import(typeof(ICalculator))]
        public ICalculator calculator;

        static void Main(string[] args)
        {
            Program p = new Program();
            String s;
            Console.WriteLine("Enter the command: ");

            while (true)    //Keep reading the commands until user exits
            {
                s = Console.ReadLine();
                Console.WriteLine(p.calculator.Calculate(s));
            }
        }
    }
}
