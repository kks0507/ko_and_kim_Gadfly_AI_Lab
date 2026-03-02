"use client";

import { useTranslations } from "next-intl";

export default function Hero() {
  const t = useTranslations("Hero");

  return (
    <section className="relative min-h-screen flex items-center justify-center dot-grid overflow-hidden">
      <div className="absolute inset-0 bg-gradient-to-b from-slate-950 via-slate-950/95 to-slate-900" />

      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-amber-500/[0.03] rounded-full blur-[120px]" />

      <div className="relative z-10 text-center px-6 max-w-4xl mx-auto">
        <p className="text-amber-400/80 text-sm tracking-[0.3em] uppercase mb-6 animate-fade-in">
          {t("affiliation")}
        </p>

        <h1 className="font-serif text-5xl sm:text-6xl md:text-7xl lg:text-8xl font-bold text-slate-50 mb-6 animate-fade-in-delay-1 tracking-tight">
          {t("title")}
        </h1>

        <p className="text-slate-400 text-lg md:text-xl mb-10 animate-fade-in-delay-2">
          {t("subtitle")}
        </p>

        <div className="animate-fade-in-delay-3">
          <p className="inline-block text-amber-400/90 text-base md:text-lg font-light italic border border-amber-400/20 rounded-full px-8 py-3 bg-amber-400/[0.04]">
            &ldquo;{t("slogan")}&rdquo;
          </p>
        </div>

        <div className="mt-16 animate-fade-in-delay-3">
          <a
            href="#about"
            className="inline-block text-slate-500 hover:text-amber-400 transition-colors duration-300"
          >
            <svg
              width="24"
              height="24"
              fill="none"
              stroke="currentColor"
              strokeWidth="1.5"
              className="animate-bounce"
            >
              <path d="M12 5v14M5 12l7 7 7-7" />
            </svg>
          </a>
        </div>
      </div>
    </section>
  );
}
