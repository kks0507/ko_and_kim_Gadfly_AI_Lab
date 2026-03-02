"use client";

import { useTranslations } from "next-intl";
import Image from "next/image";

interface MemberCardProps {
  name: string;
  role: string;
  fields: string;
  affiliation: string;
  imageSrc?: string;
  initials?: string;
  accentColor?: string;
}

function MemberCard({
  name,
  role,
  fields,
  affiliation,
  imageSrc,
  initials,
  accentColor,
}: MemberCardProps) {
  return (
    <div className="group bg-slate-900/60 border border-slate-800/60 rounded-2xl p-6 text-center transition-all duration-300 hover:border-amber-400/20 hover:shadow-[0_0_30px_rgba(251,191,36,0.04)]">
      <div className="relative w-32 h-32 mx-auto mb-5">
        {imageSrc ? (
          <div className="w-32 h-32 rounded-full overflow-hidden border-2 border-slate-700/50 group-hover:border-amber-400/30 transition-colors duration-300">
            <Image
              src={imageSrc}
              alt={name}
              width={256}
              height={256}
              className="w-full h-full object-cover object-[50%_18%]"
              priority
            />
          </div>
        ) : (
          <div
            className="w-32 h-32 rounded-full flex items-center justify-center border-2 border-slate-700/50 group-hover:border-amber-400/30 transition-colors duration-300 text-2xl font-bold"
            style={{
              backgroundColor: accentColor
                ? `${accentColor}15`
                : "rgba(251,191,36,0.08)",
              color: accentColor || "#fbbf24",
            }}
          >
            {initials}
          </div>
        )}
      </div>
      <h3 className="text-slate-100 font-semibold text-lg mb-1">{name}</h3>
      <p className="text-amber-400/80 text-sm mb-3">{role}</p>
      <p className="text-slate-500 text-xs mb-2">{fields}</p>
      <p className="text-slate-600 text-xs">{affiliation}</p>
    </div>
  );
}

export default function Team() {
  const t = useTranslations("Team");

  const directors = [
    { key: "hjko", image: "/images/hj-ko.jpg" },
    { key: "gskim", image: "/images/gs-kim.jpg" },
  ];

  const advisor = { key: "jbkim", image: "/images/jb-kim.jpg" };

  const aiResearchers = [
    { key: "claude", initials: "C", accentColor: "#d97706" },
    { key: "gemini", initials: "G", accentColor: "#3b82f6" },
  ];

  return (
    <section id="team" className="py-24 md:py-32 bg-slate-900/50">
      <div className="max-w-6xl mx-auto px-6">
        <h2 className="font-serif text-3xl md:text-4xl font-bold text-slate-50 mb-16 text-center">
          {t("sectionTitle")}
        </h2>

        <div className="space-y-16">
          {/* Co-Directors */}
          <div>
            <h3 className="text-sm text-slate-500 uppercase tracking-widest text-center mb-8">
              {t("coDirectors")}
            </h3>
            <div className="grid sm:grid-cols-2 gap-6 max-w-2xl mx-auto">
              {directors.map((d) => (
                <MemberCard
                  key={d.key}
                  name={t(`${d.key}.name`)}
                  role={t(`${d.key}.role`)}
                  fields={t(`${d.key}.fields`)}
                  affiliation={t(`${d.key}.affiliation`)}
                  imageSrc={d.image}
                />
              ))}
            </div>
          </div>

          {/* Advisor */}
          <div>
            <h3 className="text-sm text-slate-500 uppercase tracking-widest text-center mb-8">
              {t("advisor")}
            </h3>
            <div className="max-w-xs mx-auto">
              <MemberCard
                name={t(`${advisor.key}.name`)}
                role={t(`${advisor.key}.role`)}
                fields={t(`${advisor.key}.fields`)}
                affiliation={t(`${advisor.key}.affiliation`)}
                imageSrc={advisor.image}
              />
            </div>
          </div>

          {/* AI Researchers */}
          <div>
            <h3 className="text-sm text-slate-500 uppercase tracking-widest text-center mb-8">
              {t("aiResearchers")}
            </h3>
            <div className="grid sm:grid-cols-2 gap-6 max-w-2xl mx-auto">
              {aiResearchers.map((r) => (
                <MemberCard
                  key={r.key}
                  name={t(`${r.key}.name`)}
                  role={t(`${r.key}.role`)}
                  fields={t(`${r.key}.fields`)}
                  affiliation={t(`${r.key}.affiliation`)}
                  initials={r.initials}
                  accentColor={r.accentColor}
                />
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
