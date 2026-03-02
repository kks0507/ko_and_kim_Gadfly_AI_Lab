"use client";

import { useTranslations } from "next-intl";

export default function About() {
  const t = useTranslations("About");

  return (
    <section id="about" className="py-24 md:py-32 bg-slate-900/50">
      <div className="max-w-6xl mx-auto px-6">
        <h2 className="font-serif text-3xl md:text-4xl font-bold text-slate-50 mb-16 text-center">
          {t("sectionTitle")}
        </h2>

        <div className="grid md:grid-cols-2 gap-12 md:gap-16 items-start">
          <div className="space-y-6">
            <p className="text-slate-300 text-lg leading-relaxed">
              {t("vision")}
            </p>
            <p className="text-slate-400 leading-relaxed">
              {t("philosophy")}
            </p>
            <p className="text-slate-400 leading-relaxed">
              {t("description")}
            </p>
          </div>

          <div className="space-y-8">
            <div className="border-l-2 border-amber-400/60 pl-6 py-2">
              <blockquote className="text-slate-200 text-lg italic leading-relaxed">
                &ldquo;{t("quote")}&rdquo;
              </blockquote>
            </div>

            <div className="bg-slate-800/50 border border-slate-700/50 rounded-2xl p-8 glow-amber">
              <p className="text-slate-500 text-xs uppercase tracking-widest mb-3">
                Core Framework
              </p>
              <p className="font-mono text-amber-400 text-2xl md:text-3xl font-bold tracking-wide">
                {t("framework")}
              </p>
              <div className="mt-4 flex flex-wrap gap-2">
                <span className="text-xs px-3 py-1 rounded-full bg-slate-700/50 text-slate-400 border border-slate-600/30">
                  F_edu: Educational Friction
                </span>
                <span className="text-xs px-3 py-1 rounded-full bg-slate-700/50 text-slate-400 border border-slate-600/30">
                  μ_AI: AI Friction Coefficient
                </span>
                <span className="text-xs px-3 py-1 rounded-full bg-slate-700/50 text-slate-400 border border-slate-600/30">
                  N_learner: Learner Capacity
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
