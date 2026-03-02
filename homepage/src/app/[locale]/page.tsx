import Header from "@/components/Header";
import Hero from "@/components/Hero";
import About from "@/components/About";
import Research from "@/components/Research";
import Team from "@/components/Team";
import Publications from "@/components/Publications";
import Footer from "@/components/Footer";

export default function HomePage() {
  return (
    <>
      <Header />
      <main>
        <Hero />
        <About />
        <Research />
        <Team />
        <Publications />
      </main>
      <Footer />
    </>
  );
}
