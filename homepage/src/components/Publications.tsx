"use client";

import { useTranslations } from "next-intl";

export default function Publications() {
  const t = useTranslations("Publications");

  const keywords = t("p1.keywords").split(" · ");

  return (
    <section id="publications" className="py-24 md:py-32">
      <div className="max-w-6xl mx-auto px-6">
        <h2 className="font-serif text-3xl md:text-4xl font-bold text-slate-50 mb-16 text-center">
          {t("sectionTitle")}
        </h2>

        <div className="max-w-3xl mx-auto">
          <article className="bg-slate-900/60 border border-slate-800/60 rounded-2xl p-8 transition-all duration-300 hover:border-amber-400/20">
            <div className="flex items-start justify-between gap-4 mb-4">
              <span className="shrink-0 text-xs px-3 py-1 rounded-full bg-amber-400/10 text-amber-400 border border-amber-400/20">
                {t("p1.venue")}
              </span>
              <span className="text-xs text-slate-600">{t("p1.year")}</span>
            </div>

            <h3 className="text-slate-100 font-semibold text-lg md:text-xl leading-snug mb-3">
              {t("p1.title")}
            </h3>

            <p className="text-slate-400 text-sm mb-2">{t("p1.authors")}</p>

            <p className="inline-block text-xs px-2.5 py-0.5 rounded-full bg-slate-800 text-slate-500 border border-slate-700/50 mb-5">
              {t("p1.status")}
            </p>

            <div className="flex flex-wrap gap-2 pt-4 border-t border-slate-800/50">
              {keywords.map((kw) => (
                <span
                  key={kw}
                  className="text-xs px-3 py-1 rounded-full bg-slate-800/70 text-slate-500 border border-slate-700/30"
                >
                  {kw}
                </span>
              ))}
            </div>
          </article>
        </div>
      </div>
    </section>
  );
}
