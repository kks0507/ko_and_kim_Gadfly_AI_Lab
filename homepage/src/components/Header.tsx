"use client";

import { useTranslations, useLocale } from "next-intl";
import { useRouter, usePathname } from "@/i18n/navigation";
import { useState, useEffect } from "react";

export default function Header() {
  const t = useTranslations("Header");
  const locale = useLocale();
  const router = useRouter();
  const pathname = usePathname();
  const [scrolled, setScrolled] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 50);
    window.addEventListener("scroll", onScroll);
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  const switchLocale = (newLocale: "ko" | "en") => {
    router.replace(pathname, { locale: newLocale });
  };

  const navLinks = [
    { href: "#about", label: t("about") },
    { href: "#research", label: t("research") },
    { href: "#team", label: t("team") },
    { href: "#publications", label: t("publications") },
  ];

  return (
    <header
      className={`fixed top-0 w-full z-50 transition-all duration-300 ${
        scrolled
          ? "bg-slate-950/80 backdrop-blur-xl border-b border-slate-800/50"
          : "bg-transparent"
      }`}
    >
      <nav className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
        <a href="#" className="font-serif text-amber-400 font-bold text-xl tracking-wide">
          Gadfly AI Lab
        </a>

        <div className="hidden md:flex items-center gap-8 text-sm text-slate-400">
          {navLinks.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className="hover:text-amber-400 transition-colors duration-200"
            >
              {link.label}
            </a>
          ))}
        </div>

        <div className="flex items-center gap-3">
          <div className="flex items-center gap-1 text-sm">
            <button
              onClick={() => switchLocale("ko")}
              className={`px-2.5 py-1 rounded-md transition-all duration-200 ${
                locale === "ko"
                  ? "text-amber-400 bg-amber-400/10"
                  : "text-slate-500 hover:text-slate-300"
              }`}
            >
              KO
            </button>
            <span className="text-slate-700">|</span>
            <button
              onClick={() => switchLocale("en")}
              className={`px-2.5 py-1 rounded-md transition-all duration-200 ${
                locale === "en"
                  ? "text-amber-400 bg-amber-400/10"
                  : "text-slate-500 hover:text-slate-300"
              }`}
            >
              EN
            </button>
          </div>

          <button
            onClick={() => setMenuOpen(!menuOpen)}
            className="md:hidden text-slate-400 hover:text-amber-400 transition-colors p-1"
          >
            <svg width="24" height="24" fill="none" stroke="currentColor" strokeWidth="2">
              {menuOpen ? (
                <path d="M6 6l12 12M6 18L18 6" />
              ) : (
                <path d="M4 6h16M4 12h16M4 18h16" />
              )}
            </svg>
          </button>
        </div>
      </nav>

      {menuOpen && (
        <div className="md:hidden bg-slate-950/95 backdrop-blur-xl border-b border-slate-800/50 px-6 py-4">
          {navLinks.map((link) => (
            <a
              key={link.href}
              href={link.href}
              onClick={() => setMenuOpen(false)}
              className="block py-2.5 text-slate-400 hover:text-amber-400 transition-colors"
            >
              {link.label}
            </a>
          ))}
        </div>
      )}
    </header>
  );
}
