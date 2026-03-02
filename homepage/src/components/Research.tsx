"use client";

import { useTranslations } from "next-intl";

const icons = [
  <svg key="r1" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z" /></svg>,
  <svg key="r2" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" /><path d="M8 9h0M12 9h0M16 9h0" /></svg>,
  <svg key="r3" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>,
  <svg key="r4" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M17 7l-10 10M7 7h10v10" /></svg>,
  <svg key="r5" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M2 12h4l3-9 6 18 3-9h4" /></svg>,
];

const areaKeys = ["r1", "r2", "r3", "r4", "r5"] as const;

export default function Research() {
  const t = useTranslations("Research");

  return (
    <section id="research" className="py-24 md:py-32">
      <div className="max-w-6xl mx-auto px-6">
        <h2 className="font-serif text-3xl md:text-4xl font-bold text-slate-50 mb-16 text-center">
          {t("sectionTitle")}
        </h2>

        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {areaKeys.map((key, i) => (
            <div
              key={key}
              className={`group bg-slate-900/60 border border-slate-800/60 rounded-2xl p-7 transition-all duration-300 hover:border-amber-400/30 hover:shadow-[0_0_40px_rgba(251,191,36,0.06)] ${
                i >= 3 ? "sm:col-span-1 lg:col-span-1" : ""
              } ${i === 3 ? "lg:col-start-1" : ""}`}
            >
              <div className="w-12 h-12 rounded-xl bg-amber-400/10 flex items-center justify-center text-amber-400 mb-5 group-hover:bg-amber-400/15 transition-colors duration-300">
                {icons[i]}
              </div>
              <h3 className="text-slate-100 font-semibold text-lg mb-3 group-hover:text-amber-400 transition-colors duration-300">
                {t(`${key}.title`)}
              </h3>
              <p className="text-slate-400 text-sm leading-relaxed">
                {t(`${key}.description`)}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
